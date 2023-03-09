FROM thevlang/vlang:alpine-dev AS builder

RUN apk update && apk upgrade
RUN apk --no-cache add upx

WORKDIR /app
COPY . .
RUN mkdir bin && /opt/vlang/v -prod -o bin/cv app.v

FROM alpine AS runtime

RUN apk update && apk upgrade \
    && apk add --no-cache openssl

WORKDIR /app
COPY --from=builder /app/bin/ .
COPY --from=builder /app/src .

EXPOSE 8080
CMD [ "./cv" ]
