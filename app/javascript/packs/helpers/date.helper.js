export default {
  methods: {
    parseDate(dateStr) {
      var date = Date.parse(dateStr);
      return new Date(date);
    }
  }
}