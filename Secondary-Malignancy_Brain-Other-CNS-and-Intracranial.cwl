cwlVersion: v1.0
steps:
  read-potential-cases-fhir:
    run: read-potential-cases-fhir.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule1
  spinal-secondary-malignancy_brain-other-cns-and-intracranial---primary:
    run: spinal-secondary-malignancy_brain-other-cns-and-intracranial---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule2
      potentialCases:
        id: potentialCases
        source: read-potential-cases-fhir/output
  cerebral-secondary-malignancy_brain-other-cns-and-intracranial---primary:
    run: cerebral-secondary-malignancy_brain-other-cns-and-intracranial---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule3
      potentialCases:
        id: potentialCases
        source: spinal-secondary-malignancy_brain-other-cns-and-intracranial---primary/output
  secondary-malignancy_brain-other-cns-and-intracranial-neoplasm---primary:
    run: secondary-malignancy_brain-other-cns-and-intracranial-neoplasm---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule4
      potentialCases:
        id: potentialCases
        source: cerebral-secondary-malignancy_brain-other-cns-and-intracranial---primary/output
  secondary-malignancy_brain-other-cns-and-intracranial---primary:
    run: secondary-malignancy_brain-other-cns-and-intracranial---primary.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule5
      potentialCases:
        id: potentialCases
        source: secondary-malignancy_brain-other-cns-and-intracranial-neoplasm---primary/output
  output-cases:
    run: output-cases.cwl
    out:
    - output
    in:
      inputModule:
        id: inputModule
        source: inputModule6
      potentialCases:
        id: potentialCases
        source: secondary-malignancy_brain-other-cns-and-intracranial---primary/output
class: Workflow
inputs:
  inputModule1:
    id: inputModule1
    doc: Js implementation unit
    type: File
  inputModule2:
    id: inputModule2
    doc: Python implementation unit
    type: File
  inputModule3:
    id: inputModule3
    doc: Python implementation unit
    type: File
  inputModule4:
    id: inputModule4
    doc: Python implementation unit
    type: File
  inputModule5:
    id: inputModule5
    doc: Python implementation unit
    type: File
  inputModule6:
    id: inputModule6
    doc: Python implementation unit
    type: File
outputs:
  cases:
    id: cases
    type: File
    outputSource: output-cases/output
    outputBinding:
      glob: '*.csv'
requirements:
  SubworkflowFeatureRequirement: {}
