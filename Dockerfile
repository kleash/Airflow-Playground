FROM python:latest

ENV AIRFLOW_HOME=/app/airflow

RUN mkdir -p /app/airflow && \
	pip install PyMySQL 'apache-airflow[mysql,dask,celery,rabbitmq,redis,ldap,ssh]'

ADD airflow.cfg /app/airflow

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

WORKDIR /app/airflow

ENTRYPOINT ["/entrypoint.sh"]
CMD ["webserver"]
