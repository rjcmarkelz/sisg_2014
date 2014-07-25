void convolve(double *x, int *n, double *y, int *m, double *z){
int i, j, nz = *m + *n - 1;
for(i = 0; i < nz; i++) z[i] = 0.0;
for(i = 0; i < *n; i++) {
for(j = 0; j < *m; j++){
z[i + j] += x[i] * y[j];
}
}
}

