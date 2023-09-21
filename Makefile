ARTIFACT_ID:=backstage-public-test-service

docker_login:
	docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)

build:
	./mvnw clean install -DskipTests

test:
	./mvnw test

dockerise: docker_login
	docker build -t $(DOCKER_USERNAME)/$(ARTIFACT_ID) .

publish:
	docker push $(DOCKER_USERNAME)/$(ARTIFACT_ID)

deploy: docker_login
	kubectl apply -f deploy.yaml
	[[ -z "$(lsof -Pi :8080 -sTCP:LISTEN)" ]] && echo "Port in use"  || kubectl port-forward $(ARTIFACT_ID) 8080:8080

delete:
	kubectl delete -f deploy.yaml

all: build test dockerise publish deploy
