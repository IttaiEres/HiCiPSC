#' @title An ad hoc approach for testing mediation effect
#'
#' @description Different from the joint modeling approach, the direct effect is estimated using data after regressing the effect of mediating variable out from the dependent variable. In addition, voom transformation is applied to the expression data for estimating the condition effect.
#'
#' @param Y gene by sample matrix (G by N) of log2 normalize gene expression.
#' @param X vector of length N; sample condition labels, assumed to be binary for now.
#' @param M data for the mediating variable, gene by sample matrix (G by N).
#'
#'
#' @examples
#' #library(medinome)
#' #library(limma)
#' #df <- get(load(file="../data/example-kidney-v-heart-human.rda"))
#' #Y <- df$exprs_pair
#' #M <- df$methyl_pair
#' #X <- df$tissue
#' #cov <- df$RIN
#' # include covariate
#' # fit <- mediate.test.regressing(Y=Y, X=X, M=M, cov=NULL)
#'
#' # not including covariate
#' # fit <- mediate.test.regressing(Y=Y, X=X, M=M, cov=cov)
#'
#' #ash_reg <- ash(betahat=fit$d, sebetahat=fit$d_se, lik=lik_normal())
#'
#' @export

mediate.test.regressing <- function(Y, X, M, cov=NULL) {
  
  library(limma)
  library(assertthat)
  
  # evaluate argument conditions
  assert_that(all.equal(dim(Y), dim(M)))
  assert_that(all.equal(length(unique(X)), 2))
  assert_that(all.equal(length(X), dim(Y)[2]))
  
  G <- nrow(Y)
  Y <- as.matrix(Y)
  
  # model 1: Y_g ~ \tau_g X
  # specify tissue coding
  if (!is.null(cov)) {
    design_1 <- model.matrix(~X+cov)
  } else {
    design_1 <- model.matrix(~X)
  }
  
  
  #Y_voom <- voom(Y, design=design_1, normalize.method = "none")
  model_1 <- lmFit(Y, design_1)
  #model_1 <- eBayes(model_1)
  
  # model 2: Y_g ~ \kappa_g M_g
  # to regress out the effect of mediating variable from Y
  Y_resid <- array(0, dim = dim(Y))
  for (g in 1:G){
    Y_resid[g,] <- lm(Y[g, ] ~ as.numeric(M[g, ]))$resid
  }
  rownames(Y_resid) <- rownames(Y)
  #Y_resid_voom <- vooma(Y_resid, design=design_1, plot=FALSE)
  
  # model 3: Y_resid_g ~ \tau^{\prime}_g X
  model_3 <- lmFit(Y_resid, design_1)
  
  # get effect sizes
  beta1 <- coef(model_1[,2])
  beta3 <- coef(model_3[,2])
  
  se_beta1 <- se_beta2 <- se_beta3 <- cov_beta13 <- vector("numeric", G)
  
  # <---- get variances of \tau_g (condition effect)
  se_beta1 <- model_1$sigma*sqrt(model_1$cov.coefficients[2,2])
  
  # <---- get variances of \kappa_g mediator variable effect
  for (g in 1:length(se_beta2)) {
    design_2g <- model.matrix(~ as.numeric(M[g,]))
    sigma_g <- model_1$sigma[g]
    se_beta2[g] <- sigma_g*sqrt((solve(t(design_2g)%*%design_2g))[2,2])
  }
  
  # <---- get variances of \tau^{\prime}_g condition effect on expression after
  # regressing out mediating variable
  A <- solve(t(design_1)%*%design_1)%*%t(design_1)
  contr.vector <- array(c(0,1), dim=c(2,1))
  
  # compute beta3 by hand
  for (g in 1:length(se_beta3)) {
    M_g <- t(M[g,])
    design_2g <- model.matrix(~ as.numeric(M_g))
    A_2g <- solve(t(design_2g)%*%design_2g)%*%t(design_2g)
    sigma_g <- model_1$sigma[g]
    var_beta2g <- (se_beta2^2)[g]
    var_part1 <- (se_beta1[g])^2
    var_part2 <- ( A%*%M_g%*%var_beta2g%*%t(M_g)%*%t(A) )[2,2]
    var_part3 <- ( 2*(sigma_g^2)*A%*%t(A_2g)%*%contr.vector%*%t(M_g)%*%t(A) )[2,2]
    se_beta3[g] <- sqrt(var_part1 + var_part2 + var_part3)
  }
  
  # cov(beta1,beta3)
  for (g in 1:length(cov_beta13)) {
    M_g <- t(M[g,])
    design_2g <- model.matrix(~ as.numeric(M_g))
    A_2g <- solve(t(design_2g)%*%design_2g)%*%t(design_2g)
    sigma_g <- model_1$sigma[g]
    var_part1 <- (se_beta1[g])^2
    cov_beta13[g] <- var_part1 - (sigma_g^2)*((A %*% t(A_2g) %*%contr.vector%*%t(M_g)%*%t(A))[2,2])
  }
  
  # cov(beta1-beta3)
  d_se <- sqrt(se_beta1^2 + se_beta3^2 - 2*cov_beta13)
  d <- beta1-beta3
  
  df <- data.frame(d=as.numeric(d), d_se=d_se, tau = as.numeric(beta1),
                   tau_prime = as.numeric(beta3))
  rownames(df) <- rownames(Y)
  return(df)
}
