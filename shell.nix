with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    tanka
    jsonnet-bundler
    kubectl
    docker
    docker-compose
    terraform
  ];
}
