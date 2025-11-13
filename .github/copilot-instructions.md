# Azure Monitor Baseline Alerts (AMBA)

Azure Monitor Baseline Alerts (AMBA) is a comprehensive repository providing baseline alerting guidance and Infrastructure as Code (IaC) templates for Azure resources. The project includes a Hugo-based documentation website, Azure ARM/Bicep templates, and Python tooling for alert management.

**CRITICAL**: Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Bootstrap, Build, and Test the Repository

**NEVER CANCEL any build or test commands. All timing estimates include safety margins.**

1. **Install Hugo Extended (Required for documentation site)**:
   ```bash
   wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.117.0/hugo_extended_0.117.0_linux-amd64.deb
   sudo dpkg -i /tmp/hugo.deb
   hugo version  # Verify installation
   ```

2. **Install Python dependencies**:
   ```bash
   # For alert export tooling
   cd tooling/export-alerts
   pip install -r requirements.txt  # Installs pyyaml, openpyxl
   
   # For template generation
   cd ../generate-templates  
   pip install -r requirements.txt  # Installs pyyaml
   ```

3. **Build Hugo documentation site**:
   ```bash
   cd /path/to/repo/root
   hugo --gc --minify
   ```
   - **Duration**: 15 seconds - NEVER CANCEL. Set timeout to 60+ seconds.
   - **Output**: Static site files in `./public/` directory
   - **Pages generated**: ~432 pages, ~735 non-page files, ~3001 static files

4. **Export alert definitions** (validates Python tooling):
   ```bash
   cd tooling/export-alerts
   python export-alerts.py --path ../../services --template ./alerts-template.xlsx --output-xls ../../services/amba-alerts.xlsx --output-json ../../services/amba-alerts.json --output-yaml ../../services/amba-alerts.yaml
   ```
   - **Duration**: 5 seconds - NEVER CANCEL. Set timeout to 30+ seconds.
   - **Output**: Generates Excel, JSON, and YAML files with consolidated alert definitions

### Run the Development Environment

**ALWAYS run the bootstrapping steps first.**

1. **Run Hugo development server**:
   ```bash
   hugo server -D
   ```
   - **Duration**: 15 seconds initial build - NEVER CANCEL. Set timeout to 60+ seconds.
   - **Access**: http://localhost:1313/azure-monitor-baseline-alerts/
   - **Note**: Server watches for changes and rebuilds automatically

2. **Test Bicep compilation**:
   ```bash
   # Example: Compile policy set definitions
   bicep build patterns/alz/templates/policySets.bicep --outfile /tmp/policySets.json
   
   # Example: Compile network policies  
   bicep build patterns/alz/templates/policies-Network.bicep --outfile /tmp/policies-Network.json
   ```
   - **Duration**: 3-5 seconds per file - NEVER CANCEL. Set timeout to 30+ seconds.

## Validation

**ALWAYS manually validate any new code via the following steps after making changes.**

### Required Validation Steps

1. **YAML validation** (for alert definitions):
   ```bash
   python .github/yml-schemas/validate_yml.py "path/to/alerts.yaml"
   ```
   - **Duration**: <5 seconds - Set timeout to 30+ seconds.
   - **Purpose**: Validates alert definition schema compliance

2. **Hugo site build validation**:
   ```bash
   hugo --gc --minify
   ```
   - **Duration**: 15 seconds - NEVER CANCEL. Set timeout to 60+ seconds.
   - **Purpose**: Ensures documentation builds successfully

3. **Alert export validation**:
   ```bash
   cd tooling/export-alerts
   python export-alerts.py --path ../../services --template ./alerts-template.xlsx --output-xls /tmp/test-alerts.xlsx --output-json /tmp/test-alerts.json --output-yaml /tmp/test-alerts.yaml
   ```
   - **Duration**: 5 seconds - Set timeout to 30+ seconds.
   - **Purpose**: Ensures alert processing tooling works correctly

### Manual Testing Scenarios

**ALWAYS test these scenarios after making changes to ensure functionality:**

1. **Documentation Site Navigation**:
   - Start Hugo server: `hugo server -D`
   - Navigate to http://localhost:1313/azure-monitor-baseline-alerts/
   - Test key pages: Welcome, Patterns/ALZ, Services sections
   - Verify search functionality works

2. **Alert Definition Processing**:
   - Modify an alert in `services/{service}/{resource}/alerts.yaml`
   - Run export script to verify processing works
   - Check generated outputs contain your changes

3. **Bicep Template Validation**:
   - Make changes to templates in `patterns/alz/templates/`
   - Compile with `bicep build` to verify syntax
   - Check for any compilation errors

## CI Validation Requirements

**Always run these commands before committing to ensure CI will pass:**

1. **YAML Schema Validation**:
   ```bash
   # Test changed YAML files
   python .github/yml-schemas/validate_yml.py "path/to/changed/alerts.yaml"
   ```

2. **Hugo Build Check**:
   ```bash
   hugo --gc --minify
   ```
   - **Must complete successfully** - site must build without errors

3. **Bicep Compilation Check**:
   ```bash
   # For any modified .bicep files
   bicep build path/to/template.bicep --outfile /tmp/output.json
   ```

## Repository Structure and Key Locations

### Most Important Directories

- **`docs/`**: Hugo documentation source files
  - `docs/content/`: Markdown content for the website
  - `docs/themes/hugo-geekdoc/`: GeekDoc theme for Hugo
- **`services/`**: Alert definitions organized by Azure service
  - `services/{Service}/{Resource}/alerts.yaml`: Alert definitions
  - `services/{Service}/{Resource}/templates/`: ARM/Bicep templates
- **`patterns/alz/`**: Azure Landing Zone (ALZ) patterns and policies
  - `patterns/alz/templates/`: Bicep policy templates
  - `patterns/alz/policyDefinitions/`: Generated policy definitions
- **`tooling/`**: Python scripts for processing alerts and templates
  - `tooling/export-alerts/`: Script to export consolidated alert definitions
  - `tooling/generate-templates/`: Script to generate ARM/Bicep templates

### Key Configuration Files

- **`config/_default/hugo.toml`**: Hugo site configuration
- **`.github/workflows/`**: GitHub Actions workflows for CI/CD
- **`.github/linters/`**: Linting configuration (.markdown-lint.yml, .eslintrc.yml)

## Common Build Errors and Solutions

1. **Hugo Build Fails**:
   - Check Hugo version: `hugo version` (must be 0.117.0+ Extended)
   - Verify config file syntax in `config/_default/hugo.toml`
   - Check for missing theme: `docs/themes/hugo-geekdoc/` must exist

2. **Python Script Errors**:
   - Install dependencies: `pip install -r requirements.txt` in appropriate tooling directory
   - Check Python version: `python3 --version` (requires 3.12+)
   - Verify YAML syntax in alert definition files

3. **Bicep Compilation Errors**:
   - Check Bicep installation: `bicep --version`
   - Verify template syntax and references
   - Ensure all referenced files exist

## Timing Expectations

**CRITICAL**: Set appropriate timeouts for all operations. These are measured times with safety margins:

- **Hugo site build**: 15 seconds (set timeout: 60+ seconds)
- **Hugo server startup**: 15 seconds (set timeout: 60+ seconds)  
- **Python alert export**: 5 seconds (set timeout: 30+ seconds)
- **Bicep compilation**: 3-5 seconds per file (set timeout: 30+ seconds)
- **YAML validation**: <5 seconds (set timeout: 30+ seconds)
- **Python dependency installation**: 10-30 seconds (set timeout: 120+ seconds)

## Common Development Tasks

### Adding New Alert Definitions

1. Navigate to appropriate service directory: `services/{Service}/{Resource}/`
2. Edit `alerts.yaml` file following existing schema
3. Test with: `python .github/yml-schemas/validate_yml.py "services/{Service}/{Resource}/alerts.yaml"`
4. Regenerate outputs: `cd tooling/export-alerts && python export-alerts.py --path ../../services --template ./alerts-template.xlsx --output-xls ../../services/amba-alerts.xlsx --output-json ../../services/amba-alerts.json --output-yaml ../../services/amba-alerts.yaml`

### Modifying Documentation

1. Edit markdown files in `docs/content/`
2. Test locally: `hugo server -D`
3. Verify build: `hugo --gc --minify`
4. Check generated site at http://localhost:1313/azure-monitor-baseline-alerts/

### Working with ALZ Policies

1. Modify Bicep templates in `patterns/alz/templates/`
2. Compile: `bicep build patterns/alz/templates/{template}.bicep --outfile /tmp/{template}.json`
3. Test deployment parameters in `patterns/alz/alzArm.param.json`

## File Type Handlers

**Always check these file locations after making changes:**

- **alerts.yaml changes**: Run export script to update consolidated outputs
- **Bicep template changes**: Compile with `bicep build` to verify syntax
- **Documentation changes**: Build Hugo site to verify rendering
- **Policy changes**: Update and compile relevant policy template files

This repository does NOT require traditional package managers like npm or traditional build systems like Make. The toolchain is Hugo + Python + Bicep CLI.