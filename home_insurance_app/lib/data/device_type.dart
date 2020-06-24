// Enum is used to  ensure that the device types do not take invalid strings .
enum DeviceType {
  SMOKE_CO_DETECTOR,
  THERMOSTAT,
  CAMERA,
  DOORBELL,
}

List<String> deviceName = [
  'Smoke Detector',
  'Thermostat',
  'Camera',
  'Doorbell'
];

Map<String, DeviceType> getDeviceType = {
  'Smoke Detector': DeviceType.SMOKE_CO_DETECTOR,
  'Thermostat': DeviceType.THERMOSTAT,
  'Camera': DeviceType.CAMERA,
  'Doorbell': DeviceType.DOORBELL
};

Map<String, DeviceType> sdmToDeviceType = {
  'sdm.devices.types.SMOKE_CO_DETECTOR': DeviceType.SMOKE_CO_DETECTOR,
  'sdm.devices.types.THERMOSTAT': DeviceType.THERMOSTAT,
  'sdm.devices.types.CAMERA': DeviceType.CAMERA,
  'sdm.devices.types.DOORBELL': DeviceType.DOORBELL
};
