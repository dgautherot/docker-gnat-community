# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
DOCKER := docker
DOCKER_HUB_ID := dgautherot

TAG_NAME_FOR_X86_64_LINUX := x86_64-linux.2019.2
DOCKER_FILE_FOR_X86_64_LINUX := Dockerfile.x86_64-linux

GNAT_COMMUNITY := gnat-community
GNAT_COMMUNITY_IMAGES := $(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX)

# --------------------------------------------------------------------------- #
# x86_64-linux reachable targets
# --------------------------------------------------------------------------- #
.PHONY: image-x86_64-linux push-to-dockerhub-x86_64-linux clean-x86_64-linux

image-x86_64-linux:
	$(DOCKER) build -f $(DOCKER_FILE_FOR_X86_64_LINUX) -t $(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX) .

push-to-dockerhub-x86_64-linux:
	$(DOCKER) tag $(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX) $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX)
	$(DOCKER) push $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX)

clean-x86_64-linux:
	-$(DOCKER) image rm -f $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX)
	-$(DOCKER) image rm -f $(GNAT_COMMUNITY):$(TAG_NAME_FOR_X86_64_LINUX)

# --------------------------------------------------------------------------- #
# Global reachable targets
# --------------------------------------------------------------------------- #
.PHONY: images clean push-to-dockerhub

images: image-x86_64-linux

clean: clean-x86_64-linux
	docker system prune -f

push-to-dockerhub: push-to-dockerhub-x86_64-linux
