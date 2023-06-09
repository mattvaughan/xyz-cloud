function fn() {   
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'local'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    baseUrl: 'http://localhost:5000'
  };
  if (env == 'buildkite') {
    // over-ride only those that need to be
    config.baseUrl = 'http://' + java.lang.System.getenv('xyz_api_url');
  }
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
