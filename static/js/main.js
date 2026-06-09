document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("note-form");
  const notesList = document.getElementById("notes-list");

  function renderNotes(notes) {
    if (!notesList) return;
    notesList.innerHTML = notes.map((note) => {
      const attachmentLink = note.filename ? `<a href='/uploads/${note.filename}'>Download</a>` : "";
      return `
        <div class='note-card'>
          <h3>${note.title}</h3>
          <p>${note.body}</p>
          <div class='note-meta'>${note.created_at} ${attachmentLink}</div>
        </div>
      `;
    }).join("");
  }

  async function loadNotes() {
    const response = await fetch("/api/notes");
    if (response.ok) {
      const notes = await response.json();
      renderNotes(notes);
    }
  }

  if (form) {
    form.addEventListener("submit", async (event) => {
      event.preventDefault();

      const formData = new FormData(form);
      const response = await fetch("/api/notes", {
        method: "POST",
        body: formData,
      });

      if (response.ok) {
        form.reset();
        loadNotes();
      }
    });
  }

  loadNotes();
});
