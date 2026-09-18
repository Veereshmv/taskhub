# TaskHub – Microservices Application Platform on Azure

## Project Overview

This project demonstrates a cloud-based application platform on Microsoft Azure, with a focus on containerization, Kubernetes deployment, infrastructure automation, and CI/CD.

The infrastructure is provisioned and maintained using Terraform, including Azure Kubernetes Service (AKS), Azure Container Registry (ACR), Azure SQL Database, Azure Storage, Azure Key Vault, and Azure App Service. Application components are packaged as Docker containers and stored in ACR.

Azure DevOps YAML pipelines are used to build and publish container images and deploy application workloads. Backend services run on AKS using Kubernetes Deployments, Services, ConfigMaps, Secrets, health probes, and NGINX Ingress. The frontend is deployed as a container on Azure App Service.

Sensitive application credentials are managed through Azure Key Vault, while Kubernetes configuration is handled using ConfigMaps and Secrets.

Overall, the project demonstrates the practical use of Terraform, Docker, Azure DevOps, AKS, ACR, Kubernetes, and Azure services to deploy and manage a containerized application in Azure.

## Architecture

Developer
   |
   v
Azure Repos
   |
   v
Azure DevOps CI
   |
   v
Docker Images
   |
   v
Azure Container Registry
   |
   v
Azure DevOps CD
   |
   +-------------------+
   |                   |
   v                   v
  AKS             Azure App Service
   |                   |
   v                Frontend
NGINX Ingress
   |
   +----------+----------+
   |                     |
   v                     v
Task Service        File Service
   |                     |
   v                     v
Azure SQL          Azure Blob Storage
