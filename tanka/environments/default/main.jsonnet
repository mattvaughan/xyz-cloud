{
  // Xyz API
  xyz: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'xyz',
      },
      spec: {
        selector: {
          matchLabels: {
            name: 'xyz',
          },
        },
        template: {
          metadata: {
            labels: {
              name: 'xyz',
            },
          },
          spec: {
            containers: [
              {
                image: 'mattvaughan/xyz-api',
                name: 'xyz',
                ports: [{
                    containerPort: 80,
                    name: 'api',
                }],
              },
            ],
          },
        },
      },
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: 'xyz',
        },
        name: 'xyz',
      },
      spec: {
        ports: [{
            name: 'xyz',
            port: 80,
            targetPort: 80,
        }],
        selector: {
          name: 'xyz',
        },
        type: 'ClusterIP',
      },
    },
    ingress: {
      apiVersion: 'networking.k8s.io/v1',
      kind: 'Ingress',
      metadata: {
        labels: {
          name: 'xyz',
        },
        name: 'xyz',
      },
      spec: {
        rules: [
          {
            http: {
              paths: [
                {
                  path: '/',
                  pathType: 'Prefix',
                  backend: {
                    service: {
                      name: 'xyz',
                      port: {
                        number: 80
                      }
                    }
                  }
                }
              ]
            }
          },
        ],
      },
    },
  },
}
