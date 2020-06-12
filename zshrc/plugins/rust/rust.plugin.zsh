# rust path
export CARGO_PATH=${HOME}/.cargo
if [ -d ${CARGO_PATH} ]; then
  export PATH=${CARGO_PATH}/bin:$PATH
fi
