#!/bin/bash

set -e

PROJECT_NAME="corda-loan-banking-platform"

echo " Création du projet $PROJECT_NAME..."

mkdir $PROJECT_NAME
cd $PROJECT_NAME

#########################################
# STRUCTURE
#########################################

mkdir -p contracts/src/main/kotlin/com/template/contracts
mkdir -p workflows/src/main/kotlin/com/template/{states,flows}
mkdir -p clients/spring-server/src/main/kotlin/com/template/{api,service,dto,config}
mkdir -p clients/spring-server/src/main/resources
mkdir -p frontend/src/{api,components,pages}
mkdir -p database
mkdir -p docker/corda-node
mkdir -p .github/workflows

touch README.md docker-compose.yml install.sh

#########################################
# README
#########################################

cat > README.md <<EOF
# Corda Loan Banking Platform

Full-stack banking demo using Corda, Spring Boot and React.
EOF

#########################################
# CONTRACT
#########################################

cat > contracts/src/main/kotlin/com/template/contracts/LoanContract.kt <<EOF
package com.template.contracts

class LoanContract
EOF

#########################################
# STATE
#########################################

cat > workflows/src/main/kotlin/com/template/states/LoanState.kt <<EOF
package com.template.states

data class LoanState(val amount: Int)
EOF

#########################################
# FLOW
#########################################

cat > workflows/src/main/kotlin/com/template/flows/CreateLoanFlow.kt <<EOF
package com.template.flows

class CreateLoanFlow
EOF

#########################################
# BACKEND - CONTROLLER
#########################################

cat > clients/spring-server/src/main/kotlin/com/template/api/LoanController.kt <<EOF
package com.template.api

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/loan")
class LoanController {

    @GetMapping
    fun hello() = "Loan API running"
}
EOF

#########################################
# BACKEND - SERVICE
#########################################

cat > clients/spring-server/src/main/kotlin/com/template/service/LoanService.kt <<EOF
package com.template.service

import org.springframework.stereotype.Service

@Service
class LoanService
EOF

#########################################
# FRONTEND
#########################################

cat > frontend/src/pages/Home.jsx <<EOF
export default function Home() {
  return <h1>Corda Loan Dashboard</h1>;
}
EOF

#########################################
# DOCKER COMPOSE
#########################################

cat > docker-compose.yml <<EOF
version: "3.8"
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: corda
      POSTGRES_USER: corda
      POSTGRES_PASSWORD: corda
    ports:
      - "5432:5432"

  backend:
    image: openjdk:17
    ports:
      - "8080:8080"

  frontend:
    image: node:18
    ports:
      - "3000:3000"
EOF

#########################################
# DATABASE
#########################################

cat > database/init.sql <<EOF
CREATE TABLE loans (
    id VARCHAR(64) PRIMARY KEY,
    amount INT
);
EOF

#########################################
# INSTALL SCRIPT
#########################################

cat > install.sh <<EOF
#!/bin/bash
echo "Starting project..."
docker-compose up
EOF

chmod +x install.sh

#########################################
# GIT INIT
#########################################

git init
git add .
git commit -m "Initial commit - Corda loan project"

echo ""
echo "Projet généré avec succès !"

