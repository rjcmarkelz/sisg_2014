#include "Rinternals.h"
SEXP convolve2(SEXP x, SEXP y){
	int i, j, m,n, nz;
	SEXP z;
	m = LENGTH(x);
	n = LENGTH(y);
	PROTECT(z = allocVector(REALSXP, m+n-1));
	for(i =0; i< n+m-1; i++) REAL(z)[i]=0;
		for(i = 0; i < m; i++) {
			for(j = 0; j < n; j++){
				REAL(z)[i + j] += REAL(x)[i] * REAL(y)[j];
			}
		}
UNPROTECT(1); /*z*/
return z;
}
