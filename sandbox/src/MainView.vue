<template>
    <div style="width: 1000px; margin-left: auto; margin-right: auto;">
        <h1>Vue editor.js</h1>
        <button @click="reset">
            Reset
        </button>
        <vue-editorjs v-model="blocks" />
    </div>
</template>

<script>
  import VueEditorjs from '../../src/VueEditorjs'

  export default {
    name: 'MainView',

    components: {
      VueEditorjs,
    },

    data () {
      return {
        blocks: [{
          type: 'paragraph',
          data: { text: 'Editor initial text' },
        }],
      }
    },

    methods: {
      reset () {
        this.blocks = [{
          type: 'paragraph',
          data: { text: 'Editor initial text' },
        }]
      },
    },
  }
</script>
