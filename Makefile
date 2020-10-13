# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
DOCKER := docker
DOCKER_HUB_ID := dgautherot

GNAT_COMMUNITY := gnat-community

GNAT_RELEASE ?= 2020

TAG_NAME_FOR_X86_64_LINUX := x86_64-linux.${GNAT_RELEASE}
DOCKER_FILE_FOR_X86_64_LINUX := Dockerfile.${GNAT_RELEASE}.x86_64-linux

TAG_NAME_FOR_ARM_ELF_LINUX := arm_elf-linux.${GNAT_RELEASE}
DOCKER_FILE_FOR_ARM_ELF_LINUX := Dockerfile.${GNAT_RELEASE}.arm_elf-linux

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
# arm_elf-linux reachable targets
# --------------------------------------------------------------------------- #
.PHONY: image-arm_elf-linux push-to-dockerhub-arm_elf-linux clean-arm_elf-linux

image-arm_elf-linux:
	$(DOCKER) build -f $(DOCKER_FILE_FOR_ARM_ELF_LINUX) -t $(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX) .

push-to-dockerhub-arm_elf-linux:
	$(DOCKER) tag $(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX) $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX)
	$(DOCKER) push $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX)

clean-arm_elf-linux:
	-$(DOCKER) image rm -f $(DOCKER_HUB_ID)/$(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX)
	-$(DOCKER) image rm -f $(GNAT_COMMUNITY):$(TAG_NAME_FOR_ARM_ELF_LINUX)

# --------------------------------------------------------------------------- #
# Global reachable targets
# --------------------------------------------------------------------------- #
.PHONY: images clean push-to-dockerhub

images: image-x86_64-linux image-arm_elf-linux

clean: clean-x86_64-linux clean-arm_elf-linux
	docker system prune -f

push-to-dockerhub: push-to-dockerhub-x86_64-linux push-to-dockerhub-arm_elf-linux
