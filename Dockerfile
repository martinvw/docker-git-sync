FROM nginx

RUN apt-get update && apt-get install -qq -y \
  cron \
  git \
  && rm -rf /var/lib/apt/lists/*

COPY update_repo.bash /etc/cron.hourly/
RUN chmod +x /etc/cron.hourly/update_repo.bash

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

