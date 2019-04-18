FROM alpine as builder

RUN apk add --no-cache ca-certificates && \
    mkdir /user && \
    echo '1000:x:65534:65534:1000:/:' > /user/passwd && \
    echo '1000:x:65534:' > /user/group


FROM scratch

WORKDIR /

COPY --from=builder /user/group /user/passwd /etc/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER 1000:1000


