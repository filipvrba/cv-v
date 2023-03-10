FROM thevlang/vlang:alpine-dev AS builder

RUN apk update && apk upgrade
RUN apk --no-cache add upx

WORKDIR /app
COPY . .
RUN /opt/vlang/v install markdown && \
    /opt/vlang/v -prod -o bin/cv app.v

FROM alpine AS runtime

RUN apk update && apk upgrade \
    && apk add --no-cache openssl sqlite-dev vim

WORKDIR /app
COPY --from=builder /app/bin/ .

RUN mkdir src
COPY --from=builder /app/src ./src

EXPOSE 8080
CMD [ "./cv" ]
