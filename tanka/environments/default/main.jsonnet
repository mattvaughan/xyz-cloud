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
                image: 'mvon38/xyz:latest',
                imagePullPolicy: 'Always',
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
            protocol: 'TCP'
        }],
        selector: {
          name: 'xyz',
        },
        type: 'LoadBalancer',
      },
    },
  },
}
