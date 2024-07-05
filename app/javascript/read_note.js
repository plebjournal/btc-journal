import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import Paragraph from '@editorjs/paragraph';
import Quote from '@editorjs/quote';
import Table from '@editorjs/table'

const initializeNote = () => {
  const existingNote = document.getElementById('note-content').value
  const parsedData = existingNote && JSON.parse(existingNote) || null;

  new EditorJS({
    holder: 'editorjs',
    data: parsedData,
    readOnly: true,
    tools: {
      header: Header,
      list: {
        class: List,
        inlineToolbar: true,
        config: {
          defaultStyle: 'unordered'
        }
      },
      paragraph: {
        class: Paragraph,
        inlineToolbar: true,
      },
      quote: Quote,
      table: Table
    },
  });
};

initializeNote();