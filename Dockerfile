FROM busybox:musl

WORKDIR /app

# Copy everything
COPY . .

# busybox httpd auto-detects cgi-bin/ as CGI directory (no H: needed)
RUN chmod +x cgi-bin/router.sh cgi-bin/start.sh
RUN mkdir -p var/log var/state

EXPOSE 8080

CMD ["sh", "cgi-bin/start.sh"]
