#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main ()
{
  float raiz;
  int verifica=1, i, numero=2, primosGemeos=0, n, anterior=-1, *P;

  printf ("Digite o número i:\n");
  scanf ("%d", &i);

  P= malloc(i*sizeof(int));

  while(primosGemeos<=i)
  {
    raiz = sqrt(numero);

    for (n=2; n<=raiz; n++)
    {
      if(verifica!=0)
      {
          verifica=numero%n;
      }
    }
    if (verifica==0)
    {
      verifica=1;
    }
    else
    {
      if (numero-anterior==2)
      {
        primosGemeos++;
        P[i]=anterior;
      }
      anterior=numero;
    }
    numero++;
  }
  free(P);
  printf("Primos Gemeos(%d)=(%d,%d) \n", i, P[i], P[i]+2);
}
