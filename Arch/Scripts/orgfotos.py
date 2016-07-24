#!/usr/bin/env python3

import os, os.path
import shutil
import time
import sys

class OrganizaFotos():
    """orgfotos.py: Organiza todas as fotos da pasta pictures em um novo conjunto
de pastas por ano e mês. Os arquivos têm novos nomes baseados em sua pasta
antiga.
Argumentos de linha de comando:
    1) Pasta a organizar: -v para videos; -p para pictures (Default);
    2) Pasta de saída a ser criada em Downloads (Default="Teste").

    Ex.: ./orgafotos -v "Teste" --> Pega arquivos da pasta videos e organiza em
Downloads/Teste/videos
    """

    def __init__(self, srcPath, destPath):
        self.srcPath=srcPath
        self.destPath=destPath

    def CopiarArquivos(self):
        #Tempo inicial da função:
        self.start=time.time()
        #Checa se o diretório de saída existe e caso não o criará
        try:
            os.chdir(self.destPath)
        except:
            os.makedirs(self.destPath)
        self.numberFiles=0
        #Itera sobre todos os caminhos dentro do diretório Pictures
        for foldername, subfolders, filenames in os.walk(self.srcPath):
            for filename in filenames:
                self.numberFiles+=1
                #Pega o mes e ano da ultima modificação...
                self.lastModified=(time.ctime(os.path.getmtime(str(os.path.join(foldername, filename)))).split(' '))
                #print(self.lastModified)
                self.mes=self.lastModified[1]
                self.ano=self.lastModified[-1]
                #...e adiociona como pastas ao caminho de saida
                self.newpath=os.path.join(self.destPath,self.ano,self.mes)
                #Cria os diretórios caso não existam
                if not os.path.exists(self.newpath):
                    os.makedirs(self.newpath)
                #pega o nome da pasta original e usa como nome do arquivo copiado
                #acompanhado de um número (iterator)
                self.myFolder=foldername.split(os.path.sep)
                self.iterator=1
                while True:
                    self.myName=os.path.join(self.newpath, self.myFolder[len(\
self.myFolder)-1]+'_'+str(self.iterator)+'.'+filename.split('.')[-1])
                    if os.path.exists(self.myName):
                        #print(os.path.exists(self.myName))
                        self.iterator+=1
                        continue
                    else:
                        #print(os.path.exists(self.myName))
                        break
                #Imprime os caminhos de fonte e destino da cópia
                print('Copying: ' + str(os.path.join(foldername, filename)) + '\nTo: '
                            +str(self.myName))
                #copia os arquivos com a função copy2 que preserva metadados
                shutil.copy2(str(os.path.join(foldername, filename)),
                                    str(self.myName))
        print('\n'*2)
        self.end=time.time()
        self.elapsed=self.end-self.start
        if self.elapsed>=3600:
           self.horas=self.elapsed//3600
           if self.elapsed%3600>=60:
               self.minutos=(self.elapsed%3600)//60
               self.segundos=(self.elapsed%3600)%60
               print('%i Arquivos processados em %i horas, %i minutos e %.2f\
 segundos' %(self.numberFiles, self.horas, self.minutos, self.segundos))
           else:
               print('%i Arquivos processados em %i horas e %.2f segundos'\
 %(self.numberFiles, self.horas, self.segundos))
        elif self.elapsed>=60:
            self.minutos=self.elapsed//60
            self.segundos=self.elapsed%60
            print('%i Arquivos processados em %i minutos e %.2f segundos'\
 %(self.numberFiles, self.minutos, self.segundos))
        else:
            print('%i Arquivos processados em %.2f segundos' %(self.numberFiles, \
self.elapsed))

if __name__=='__main__':
    #pega o path da pasta Pictures
    error="""orgfotos.py: Organiza todas as fotos da pasta pictures em um novo conjunto
de pastas por ano e mês. Os arquivos têm novos nomes baseados em sua pasta
antiga.
Argumentos de linha de comando:
    1) Pasta a organizar: -v para videos; -p para pictures;
    2) Pasta de saída a ser criada em Downloads.

    Ex.: ./orgafotos -v "Teste" --> Pega arquivos da pasta videos e organiza em
Downloads/Teste/videos
"""
    if not len(sys.argv)==3:
        print(error)
    elif not (sys.argv[1]=='-v' or sys.argv[1]=='-p'):
        print(error)
    else:
        if sys.argv[1]=='-v':
            srcPath=os.path.expanduser('~/Videos')
            destPath=os.path.join(os.path.expanduser('~/Downloads'), sys.argv[2], 'Videos')
        elif sys.argv[1]=='-p':
            srcPath=os.path.expanduser('~/Wallpapers')
            destPath=os.path.join(os.path.expanduser('~/Downloads'), sys.argv[2], 'Pictures')
        orgFotos=OrganizaFotos(srcPath, destPath)
        orgFotos.CopiarArquivos()