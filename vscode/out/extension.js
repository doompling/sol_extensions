"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = activate;
exports.deactivate = deactivate;
// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
function activate(_context) {
    // Activate on Sol language documents; no commands needed for syntax highlighting
    console.log('Sol syntax highlighting activated');
}
// This method is called when your extension is deactivated
function deactivate() { }
//# sourceMappingURL=extension.js.map