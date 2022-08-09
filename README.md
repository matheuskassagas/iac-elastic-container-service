## Antes de inicia o projeto com o init
- Sera necessario iniciar um Repo ECR na aws 
- Ter uma imagem docker, segue um projeto com passo a passo de uma imagem Django propria para utilizar aqui: 
  - https://github.com/matheuskassagas/iac-docker-elastic-beanstalk-AWS

```
cd env/prod
terraform init
terraform plan
terraform apply
```
---
- Subir imagem do docker no ecr
- Substitua: 
  - region -> regiao aws
  - aws_account_id -> id aws
```
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
```
- Substitua: 
  - docker_image_id -> id da imagem
  - region -> regiao aws
  - aws_account_id -> id aws
  - my-repository:tag -> nome do ecr 
```
docker tag docker_image_id aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
```
- Insira o nome da imagem em /infra/ecs.tf linha 30.

- use o output para acessar a aplicacao na porta 8000
---
## Metodo de conhecimento 

### Sub-redes
- Dentro dessas zonas temos, por exemplo, as sub-redes que são divididas em dois tipo: temos as sub-redes públicas que precisam de um **internet-gateway para se comunicar com a internet**, porém todas as máquinas dentro dessas sub-redes têm um IP público e acesso a internet através do grupo de segurança e do internet-gateway. Essas sub-redes são recomendadas para os load-balancers, que são os tipos de máquinas que vão receber a requisição e dividir essa requisição entre várias instâncias para termos mais capacidade de processamento ou instâncias que recebem as requisições diretamente dos usuários. Às vezes a nossa aplicação é pequena ou recebe pouca carga, por isso podemos ter só uma instância em execução. Sendo assim, não precisamos de um load balancer podemos deixar a nossa instância direto na sub-rede pública. Um outro tipo de sub-rede que temos é a privada, que precisa ao invés de um internet-gateway de um NAT-gateway. Esse NAT-gateway vai distribuir IPs privados para todas as instâncias e esses IPs privados só podem ser utilizados dentro da nossa sub-rede privado por isso não conseguimos fazer requisições através da internet para uma instância que está em uma sub-rede privada. Essas sub-redes privadas são recomendadas para instâncias com um banco de dados porque não queremos deixar o nosso banco de dados disponível para toda a internet poder acessar, isso é um problema de segurança ou para instâncias que tem o load balancer. Já que o load balancer está na sub-rede pública podemos deixar as nossas instâncias na sub-red privada, dando assim uma camada a mais de segurança para a nossa aplicação.

- O internet gateway permite que os recursos na rede pública possam acessar à internet como se fosse o modem que a operadora instala nas casas, fazendo a ligação das redes com a internet.

- O NAT gateway é um recurso que deve ficar na rede pública para receber todas as requisições que vêm da rede privada e enviá-las para o internet gateway, como se fosse um roteador de uma casa, interligando a sua rede ao modem (muitos aparelhos hoje já tem as duas função de modem e roteador; então se você tiver apenas um aparelho em casa saiba que ele faz as duas funções).