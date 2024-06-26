# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.7.1] - 2024-05-29

### Fixed

- Patch coredns PDB in coredns-adopter job. This fixes coredns not being adopted on EKS clusters.

## [0.7.0] - 2023-12-04

### Changed

- Add switches to disable and migrate PSPs.

## [0.6.5] - 2023-05-31

### Added

- Annotate the `restricted` PSP to allow the use of Seccomp Profiles.

## [0.6.4] - 2022-11-08

### Fixed

- Have coredns-adopter poll the apiserver until it's ready before starting

## [0.6.3] - 2022-10-19

### Changed

- The `kube-dns` service will not be generated anymore. This change was only required for already existing clusters with customer workload.
- The `coredns-adopter` script will fail on error.

## [0.6.2] - 2022-09-22

### Changed

- Keep the `kube-dns` service with updated label selector.

## [0.6.1] - 2022-09-13

### Fixed

- Adopt `netpol/coredns` otherwise coredns-App will fail to install.
- Need to escape dots when replacing the coredns port.

## [0.6.0] - 2022-09-06

### Changed

- The `configMap` for Workload Clusters will only be generated if the Management Cluster has the `ClusterResourceSet` capability.

### Fixed

- if `kubectl` image isn't specified, a default image will be used

## [0.5.7] - 2022-06-29

### Fixed

- Correct path for containers

## [0.5.6] - 2022-06-29

### Fixed

- Pass overridden DNS port to deployment as argument

## [0.5.5] - 2022-06-28

### Fixed

- Added specific create deployment permission
- Added specific create service permission

## [0.5.4] - 2022-06-28

### Fixed

- Added component label to pod template in deployment

## [0.5.3] - 2022-06-28

### Fixed

- Updated RBAC permissions of coredns-adopter to allow for listing resources

## [0.5.2] - 2022-06-28

### Fixed

- Removed fields not used on initial create

## [0.5.1] - 2022-06-20

### Fixed

- Function variable reference

## [0.5.0] - 2022-06-20

### Changed

- Bumped kubectl version to latest so the image includes `jq`
- Simplified the ClusterRole permissions
- Refactored the existing resource patch logic and used `jq` to more reliably modify the existing resources

## [0.4.3] - 2022-06-17

### Fixed

- Sed replace for deployment name

## [0.4.2] - 2022-06-17

### Fixed

- Fix `ClusterRole` to allow job to work with `coredns-worker` deployment.

## [0.4.1] - 2022-06-17

### Fixed

- Rename `coredns` deployment to `coredns-workers`

## [0.4.0] - 2022-06-16

### Changed

- Used `labels.selector` for the `clusterSelector` to ensure immutability across versions

## [0.3.0] - 2022-04-13

### Changed

- Reverted back to library chart to make use of parent chart templates
- Defaulting of expected values handled in templates (as library charts don't have values.yaml)

## [0.2.1] - 2022-04-13

### Fixed

- Templates are now chart-specific
- `.Values.global` used for sharing values

## [0.2.0] - 2022-04-13

### Changed

- Switched from library chart to standard chart to make use of templates and local values.yaml file

## [0.1.1] - 2022-04-12

### Fixed

- Added team annotation

## [0.1.0] - 2022-04-12

### Added

- Default PSPs ClusterResourceSet
- CoreDNS-adopter ClusterResourceSet

[Unreleased]: https://github.com/giantswarm/cluster-shared/compare/v0.7.1...HEAD
[0.7.1]: https://github.com/giantswarm/cluster-shared/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/giantswarm/cluster-shared/compare/v0.6.5...v0.7.0
[0.6.5]: https://github.com/giantswarm/cluster-shared/compare/v0.6.4...v0.6.5
[0.6.4]: https://github.com/giantswarm/cluster-shared/compare/v0.6.3...v0.6.4
[0.6.3]: https://github.com/giantswarm/cluster-shared/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/giantswarm/cluster-shared/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/giantswarm/cluster-shared/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/giantswarm/cluster-shared/compare/v0.5.7...v0.6.0
[0.5.7]: https://github.com/giantswarm/cluster-shared/compare/v0.5.6...v0.5.7
[0.5.6]: https://github.com/giantswarm/cluster-shared/compare/v0.5.5...v0.5.6
[0.5.5]: https://github.com/giantswarm/cluster-shared/compare/v0.5.4...v0.5.5
[0.5.4]: https://github.com/giantswarm/cluster-shared/compare/v0.5.3...v0.5.4
[0.5.3]: https://github.com/giantswarm/cluster-shared/compare/v0.5.2...v0.5.3
[0.5.2]: https://github.com/giantswarm/cluster-shared/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/giantswarm/cluster-shared/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/giantswarm/cluster-shared/compare/v0.4.3...v0.5.0
[0.4.3]: https://github.com/giantswarm/cluster-shared/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/giantswarm/cluster-shared/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/giantswarm/cluster-shared/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/giantswarm/cluster-shared/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/giantswarm/cluster-shared/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/giantswarm/cluster-shared/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/giantswarm/cluster-shared/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/giantswarm/cluster-shared/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-shared/releases/tag/v0.1.0
