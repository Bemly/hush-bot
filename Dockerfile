FROM busybox:musl

WORKDIR /app

# Copy everything
COPY . .

# Create /app/cgi-bin with wrapper (H:/cgi-bin resolves relative to httpd -h dir)
RUN mkdir -p /app/cgi-bin && printf '#!/bin/sh\nexec /app/bin/router.sh "$@"\n' > /app/cgi-bin/router.sh && chmod +x /app/cgi-bin/router.sh
RUN chmod +x /app/bin/router.sh
RUN mkdir -p var/log var/state

EXPOSE 8080

CMD ["sh", "bin/start.sh"]
