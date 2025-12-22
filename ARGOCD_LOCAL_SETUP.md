# Using ArgoCD with Local Directory

There are two approaches to work with your local directory:

## Approach 1: Standard Git-Based (Recommended)

1. Initialize a Git repository in this directory:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. Create a remote repository (on GitHub, GitLab, etc.) and push:
   ```bash
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

3. Update the application.yaml to point to your actual repository:
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: m5-timelapse
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: <your-actual-repo-url>
       targetRevision: HEAD
       path: m5-timelapse/k8s
     destination:
       server: https://kubernetes.default.svc
       namespace: default
     syncPolicy:
       automated:
         prune: true
         selfHeal: true
       syncOptions:
       - CreateNamespace=true
   ```

## Approach 2: Local Directory (Advanced Configuration Required)

ArgoCD is designed to work with Git repositories, not local directories. To use a local directory, you would need to:

1. Mount your local directory as a volume to the ArgoCD application controller
2. Configure the application with a special repoURL format

This requires modifying the ArgoCD installation itself, which involves:
- Adding volume mounts to the argocd-application-controller deployment
- Configuring the repo server to access local paths

This approach is not recommended for production environments as it breaks the GitOps paradigm and makes your deployments dependent on local file systems.

## Recommendation

Use Approach 1 (Git-based) as it follows GitOps best practices and is the intended way to use ArgoCD. This provides version control, audit trails, and proper declarative infrastructure management.