FROM alpine:latest
  
COPY ./build.sh /build.sh
ADD https://raw.githubusercontent.com/watterott/ATmega328PB-Testing/master/hardware/atmega328pb/avr/tools/avrdude.conf /etc/avrdude.conf

RUN apk update && apk add bash make cmake avr-libc avrdude \
    && wget http://packs.download.atmel.com/Atmel.ATmega_DFP.1.4.351.atpack \
    && mkdir -p atmel && unzip *.atpack -d atmel \
    && cp -r atmel/include/* /usr/avr/include \
    && cp -r atmel/gcc/dev/*/* /usr/avr/lib \
    && cp /usr/avr/lib/device-specs/* /usr/lib/gcc/avr/*/device-specs/ \
    && rm -rf atmel *.atpack

ENTRYPOINT ["/build.sh"]
