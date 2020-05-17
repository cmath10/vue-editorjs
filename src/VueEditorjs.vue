<template>
    <div />
</template>

<script>
  import EditorJS from '@editorjs/editorjs'

  const clone = obj => JSON.parse(JSON.stringify(obj))
  const equals = (obj1, obj2) => JSON.stringify(obj1) === JSON.stringify(obj2)

  const CARET_POSITION_END = 'end'

  export default {
    name: 'VueEditorjs',

    model: {
      prop: 'blocks',
      event: 'change',
    },

    props: {
      blocks: {
        type: Array,
        default: () => [],
      },

      autofocus: {
        type: Boolean,
        default: false,
      },
    },

    data() {
      return {
        ready: false,
      }
    },

    watch: {
      blocks () {
        if (this.ready) {
          this.reloadContent()
        }
      },
    },

    mounted () {
      this.editorjs = new EditorJS({
        holder: this.$el,
        data: {
          blocks: this.blocks,
        },
        autofocus: this.autofocus,
        onReady: () => {
          this.ready = true
        },
        onChange: () => {
          this.grabContent()
            .then(blocks => {
              this.$emit('change', blocks)
            })
            .catch(reason => {
              this.$emit('error', reason)
            })
        },
      });
    },

    beforeDestroy () {
      this.ready = false
      this.editorjs.destroy()
    },

    methods: {
      reloadContent () {
        this.grabContent()
          .then(blocks => {
            if (!equals(blocks, this.blocks)) {
              this.loadContent(this.blocks)
            }
          })
          .catch(reason => {
            this.$emit('error', reason)
          })
      },

      loadContent (blocks) {
        if (this.blocks.length) {
          this.editorjs
            .render({ blocks: clone(blocks) })
            .then(() => {
              this.editorjs.caret.focus()
              this.editorjs.caret.setToLastBlock(CARET_POSITION_END)
            })
        } else {
          this.editorjs.clear()
        }
      },

      grabContent () {
        return this.editorjs.save().then(output => output.blocks)
      },
    },
  }
</script>
