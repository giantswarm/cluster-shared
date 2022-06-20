# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/giantswarm/cluster-shared/compare/v0.5.0...HEAD
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
