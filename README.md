# JobSurelyFinal

Job service web app.

## Local development

```bash
npm install
npm run dev
```

## Build for production

```bash
npm install
npm run build
```

The production assets are emitted to `dist/`.

## Deploy on Amazon Linux (EC2)

This repo includes a deployment script that builds the frontend and installs the Nginx
configuration needed for a single-page app.

1. **Clone the repo on your EC2 instance**

   ```bash
   git clone <your-repo-url>
   cd JobSurelyFinal
   ```

2. **Run the deployment script**

   ```bash
   ./deploy/ec2-setup.sh
   ```

3. **Open the firewall/security group**

   Ensure your EC2 security group allows inbound HTTP (port 80) and HTTPS (port 443 if using TLS).

### Manual steps (if you prefer)

1. **Install Node.js (LTS)**

   ```bash
   curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
   sudo yum install -y nodejs
   node --version
   npm --version
   ```

2. **Install dependencies and build**

   ```bash
   npm install
   npm run build
   ```

3. **Serve the static build with Nginx**

   ```bash
   sudo yum install -y nginx
   sudo systemctl enable --now nginx
   sudo rm -f /usr/share/nginx/html/*
   sudo cp -r dist/* /usr/share/nginx/html/
   sudo cp deploy/nginx-jobsurely.conf /etc/nginx/conf.d/jobsurely.conf
   sudo rm -f /etc/nginx/conf.d/default.conf
   sudo nginx -t
   sudo systemctl reload nginx
   ```

If you want a custom domain + TLS, place your SSL certificate in `/etc/nginx/` and update
`/etc/nginx/nginx.conf` accordingly.
