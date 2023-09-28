#!/usr/bin/env cwl-runner

$graph:
- class: Workflow
  id: stacmaker
  label: myMockStacItem workflow
  doc: myMockStacItem workflow
  requirements: {}
  inputs:
    message:
      label: Input message
      doc: Input message
      type: string
  outputs:
  - id: stac
    type: Directory
    outputSource:
    - step_1/output_directory
  steps:
    step_1:
      in:
        message: message
      run: '#stacmaker-clt'
      out:
      - output_directory


- class: CommandLineTool
  id: stacmaker-clt
  requirements:
    DockerRequirement:
      dockerPull: grycap/cowsay
    InitialWorkDirRequirement:
      listing:
      - entryname: catalog.json
        entry: |-  
            {
                "id": "catalog",
                "stac_version": "1.0.0",
                "links": [
                    {
                        "type": "application/geo+json",
                        "rel": "item",
                        "href": "myMockStacItem/myMockStacItem.json"
                    },
                    {
                        "type": "application/json",
                        "rel": "self",
                        "href": "catalog.json"
                    }
                ],
                "type": "Catalog",
                "description": "Root catalog"
            }

      - entryname: myMockStacItem.json
        entry: |-
            {
              "stac_version": "1.0.0",
              "stac_extensions": [
                  "https://stac-extensions.github.io/eo/v1.0.0/schema.json",
                  "https://stac-extensions.github.io/projection/v1.0.0/schema.json",
                  "https://stac-extensions.github.io/view/v1.0.0/schema.json"
              ],
              "type": "Feature",
              "id": "myMockStacItem",
              "geometry": {
                  "type": "Polygon",
                  "coordinates": [
                      [
                          [
                              30.155974613579858,
                              28.80949327971016
                          ],
                          [
                              30.407037927198104,
                              29.805008695373978
                          ],
                          [
                              31.031551610920825,
                              29.815791988006527
                          ],
                          [
                              31.050481437029678,
                              28.825387639743422
                          ],
                          [
                              30.155974613579858,
                              28.80949327971016
                          ]
                      ]
                  ]
              },
              "properties": {
                  "created": "2020-09-05T06:12:56.899Z",
                  "sentinel:product_id": "S2B_MSIL2A_20191205T083229_N0213_R021_T36RTT_20191205T111147",
                  "sentinel:sequence": "0",
                  "view:off_nadir": 0,
                  "sentinel:valid_cloud_cover": true,
                  "platform": "sentinel-2b",
                  "sentinel:utm_zone": 36,
                  "proj:epsg": 32636,
                  "sentinel:grid_square": "TT",
                  "datetime": "2019-12-05T08:42:04Z",
                  "instruments": [
                      "msi"
                  ],
                  "constellation": "sentinel-2",
                  "eo:cloud_cover": 2.75,
                  "gsd": 10,
                  "sentinel:latitude_band": "R",
                  "data_coverage": 67.28,
                  "updated": "2020-09-05T06:12:56.899Z",
                  "sentinel:data_coverage": 67.28
              },
              "bbox": [
                  30.155974613579858,
                  28.80949327971016,
                  31.050481437029678,
                  29.815791988006527
              ],

              "assets": {
                  "hello": {
                      "type": "text/plain",
                      "href": "hello.txt"
                  }
              },
              "links": []
            }
      - entryname: run.sh
        entry: |-
          #!/bin/bash
          mkdir myMockStacItem
          cp myMockStacItem.json myMockStacItem/
          /usr/games/cowsay $(inputs.message) > myMockStacItem/hello.txt
          cat myMockStacItem/hello.txt
    InlineJavascriptRequirement: {}
    ResourceRequirement:
      coresMin: 1
      ramMin: 1024

  inputs:
    message:
      type: string
      inputBinding:
        position: 1

  outputs:
    output_directory:
      type: Directory
      outputBinding:
        glob: .

  baseCommand:
  - /bin/bash
  - run.sh
$namespaces:
  s: https://schema.org/
cwlVersion: v1.0
s:softwareVersion: 1.0.0
schemas:
- http://schema.org/version/9.0/schemaorg-current-http.rdf
