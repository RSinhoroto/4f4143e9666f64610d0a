#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main ()
{
  float raiz;
  unsigned int verifica=1, i=0, numero=3, primosGemeos=0, n, anterior=0, Pimax;

//  printf ("Digite o número i:\n");
//  scanf ("%d", &i);

//  P= malloc(i*sizeof(int));

  while (numero>anterior)
  {
    for(i=0; ; i++)
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
          Pimax=anterior;
  //        printf("Pimax:%d\n", Pimax);
        }
        anterior=numero;
      }
      numero++;
    }
  }
  printf("Primos Gemeos(%u)=(%u,%u) \n", i, Pimax, Pimax+2);
}
