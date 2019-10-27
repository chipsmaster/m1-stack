help:
	@echo
	@echo "Available commands:"
	@echo
	@echo "  check      : Check and print final docker compose configuration."
	@echo "  build      : (Re-)build containers."
	@echo "  run        : Run containers in this terminal."
	@echo "  clear      : Clear containers and associated volumes."
	@echo "  bash       : Start a shell on the php container with the magento user."
	@echo "  cron       : Run the cron script manually once."
	@echo "  help       : Display this help."
	@echo


.env:
	./init.sh

docker-compose.override.yml:
	./init.sh

check: .env docker-compose.override.yml
	docker version
	docker-compose version
	docker-compose config

build: check
	docker-compose build

run: check
	docker-compose up

bash:
	docker-compose exec -u magento apache bash

cron:
	docker-compose exec -u magento apache php /var/www/magento/cron.php

clear:
	docker-compose down --volumes

