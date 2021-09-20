/// The state of the provider
enum ProviderStatus {
  /// Signals the end of an Async call. Usually used at the end of an API call
  done,

  /// Signals the start of an ASYNC call. Usuallyused at the beggining of an API call
  loading,
}
