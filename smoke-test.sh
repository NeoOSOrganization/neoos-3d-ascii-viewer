#!/bin/bash
# 3D ASCII Viewer smoke test for NeoOS
# Runs after /3d-ascii-viewer.nex is installed in the OS image

set -e

echo "=== 3D ASCII Viewer Smoke Test ==="

# Test: viewer can start
/3d-ascii-viewer --help > /tmp/test.txt 2>&1 || {
    echo "FAILED: viewer startup"
    exit 1
}

# Test: help output contains expected keywords
grep -q "viewer\|model\|rotate" /tmp/test.txt || {
    echo "FAILED: help output missing keywords"
    cat /tmp/test.txt
    exit 1
}

echo "PASSED: 3D ASCII Viewer basic functionality"
exit 0