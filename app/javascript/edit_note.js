import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import Paragraph from '@editorjs/paragraph';
import Quote from '@editorjs/quote';
import Table from '@editorjs/table'

const initializeEditor = () => {
  const existingNote = document.getElementById('note_body').value
  const parsedData = existingNote && JSON.parse(existingNote) || null;

  const handleContentChanged = (api) => {
    api.saver.save().then((outputData) => {
      document.getElementById('note_body').value = JSON.stringify(outputData);
    }).catch((error) => {
      console.log(error);
    });
  };

  new EditorJS({
    holder: 'editorjs',
    data: parsedData,
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
    onChange: handleContentChanged,
  });
};

initializeEditor();