## Docker configuration

### Install Docker on Windows
1. Create environment to docker container, user powerShell as administrator and run the following command:
```bash 
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
2. Virtual machine environment enable feature, run the following command:
```bash
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
``` 
3. Download linux kernel upgrade file from [Microsoft](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

4. WSL-2 default version (into PowerShell as administrator):
```bash
    wsl --set-default-version 2
``` 
5. Linux distro installation, download from [Microsoft Store](https://aka.ms/wslstore), or From the Microsoft Store seek [Ubuntu 22.04 lts] 
		and push install button  or latest, this process takes awhile.

6. Validate WSL instance is running (into PowerShell as administrator):
```bash
    wsl --list --verbose
``` 

7. Download Docker Desktop from [Docker Hub](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

8. Open Docker Desktop and press settings button:

	- Select Resources option
		- Select WSL integration
		- Enable integration with additional distros
		
			- Ubuntu-22.04 or latest
			
	- Apply & Restart button	

### Create Dockerfile
1. Create a new file named Dockerfile in the root of the project.
2. Add the following content to the Dockerfile:
```bash
FROM python:3.11.9-alpine3.19
LABEL authors="jruiz"

# Set the working directory in the container
WORKDIR /apps/socket_01

# Copy the dependencies file to the working directory
COPY . /apps/socket_01

# Create virtual environment
RUN python -m venv venv

# Activate virtual environment
RUN . venv/bin/activate

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5001

# Run the application
CMD ["python", "app.py"]
```
3. Create local container image:
```bash	
docker build -t socket_01 .
```
4. Run the container:
```bash
docker run -d -p 5001:5001 socket_01
```
5. Check the container is running:
```bash
docker ps
```

6. Create a remote container image:
```bash	
	-- Docker Hub connection
		docker login
			- Username:
			- Password:
		
	-- Create image 
		docker build -t dferreto/socket_01:v2 .	


	-- Create proyect tag to use in Docker Hub
		docker tag dferreto/socket_01:v2 dferreto/socket_01


	-- Upload proyect to Docker Hub
		docker push dferreto/socket_01

	-- push proyect to Docker Hub Desktop

		docker push dferreto/socket_01
	 
	-- Create container with image
		docker run --name socket_01 -p 5001:5001 -d dferreto/socket_01

```	
