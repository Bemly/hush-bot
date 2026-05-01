FROM busybox:musl

WORKDIR /app

# Copy everything
COPY . .

# busybox httpd auto-detects <home>/cgi-bin/ as CGI directory (no H: config needed)
RUN mkdir -p /app/cgi-bin && printf '#!/bin/sh\nexec /app/bin/router.sh\n' > /app/cgi-bin/router.sh && chmod +x /app/cgi-bin/router.sh
RUN chmod +x /app/bin/router.sh
RUN mkdir -p var/log var/state

EXPOSE 8080

CMD ["sh", "bin/start.sh"]
