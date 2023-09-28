# stacmaker

This Common Workflow Language (CWL) workflow is designed to generate a mock STAC (SpatioTemporal Asset Catalog) item. It uses a simple command-line tool to create a STAC item with predefined properties.

## Usage

1. Ensure you have [CWLTool](https://github.com/common-workflow-language/cwltool) installed to execute this workflow.

2. Run the workflow using the following command:

   ```bash
   cwl-runner workflow.cwl#stacmaker --message "Hello World!"
   ```

   - `workflow.cwl` is the CWL workflow file.

## Input

- `message` (string): Input product reference.

## Output

- `stac` (Directory): A directory containing the generated STAC item.
