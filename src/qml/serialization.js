function serializeBlocksToXML(canvas) {
    let xml = "<Canvas>\n";

    console.log("Canvas Children:", canvas.children); // Debugging: Log all children

    canvas.children.forEach(child => {
        // Check for essential properties to identify a block
        if (child && child.x !== undefined && child.y !== undefined && child.inputLabels && child.outputLabels) {
            console.log("Serializing block:", child); // Debug: Confirm the block being serialized
            xml += "  <Block>\n";
            xml += `    <Position x="${child.x}" y="${child.y}"/>\n`;
            xml += `    <Size width="${child.width}" height="${child.height}"/>\n`;

            // Serialize input labels
            xml += "    <Inputs>\n";
            child.inputLabels.forEach(label => {
                xml += `      <Input>${label}</Input>\n`;
            });
            xml += "    </Inputs>\n";

            // Serialize output labels
            xml += "    <Outputs>\n";
            child.outputLabels.forEach(label => {
                xml += `      <Output>${label}</Output>\n`;
            });
            xml += "    </Outputs>\n";

            xml += "  </Block>\n";
        }
    });

    xml += "</Canvas>\n";
    return xml;
}

