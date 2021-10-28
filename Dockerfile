ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}

ARG POETRY_VERSION
ARG NODEJS_MAJOR_VERSION

# install nodejs so we can install jupyter-lab extensions
RUN apt-get update
RUN apt-get -y install curl git-core apt-utils
RUN curl -sL https://deb.nodesource.com/setup_$NODEJS_MAJOR_VERSION.x | bash -
RUN apt-get install -y nodejs

RUN adduser --disabled-password poetry
USER poetry
WORKDIR /home/poetry

ENV PATH="/home/poetry/.local/bin:${PATH}"
RUN pip install --user poetry==$POETRY_VERSION

COPY --chown=poetry:poetry pyproject.toml pyproject.toml

RUN poetry config virtualenvs.create false
RUN poetry update

CMD ["poetry"]
