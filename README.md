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
   sudo systemctl restart nginx
   ```

4. **Open the firewall/security group**

   Ensure your EC2 security group allows inbound HTTP (port 80) and HTTPS (port 443 if using TLS).

If you want a custom domain + TLS, place your SSL certificate in `/etc/nginx/` and update
`/etc/nginx/nginx.conf` accordingly.
