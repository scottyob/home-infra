# M5 Timelapse Server

This application receives images from M5 cameras and serves them via a web interface.

## Deployment Instructions

### Prerequisites
- A running Kubernetes cluster with ArgoCD installed
- A Git repository to host these manifests

### Steps

1. **Prepare your Git repository**:
   - Push this repository to your Git hosting service
   - Update the `repoURL` in `application.yaml` to point to your actual repository

2. **Deploy the ArgoCD Application**:
   ```bash
   kubectl apply -f application.yaml
   ```

3. **Access the application**:
   - The application will be available at http://10.11.10.5
   - Images will be accessible at http://10.11.10.5/images/
   - Metrics endpoint at http://10.11.10.5/metrics

## Endpoints

- `/post` - Accepts POST requests with image data from cameras
- `/` - Lists all stored images with previews
- `/images/<filename>` - Serves individual images
- `/metrics` - Prometheus metrics endpoint

## Image

This deployment uses the pre-built Docker image: `scottyob/m5-timelapse-server:latest`