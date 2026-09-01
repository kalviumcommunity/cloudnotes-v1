IMAGE = cloudnotes
VERSION ?= 1.0.0

build:
	docker build -t $(IMAGE):$(VERSION) -t $(IMAGE):latest .