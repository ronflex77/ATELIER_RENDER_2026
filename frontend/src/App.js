import React, { useEffect, useState } from 'react';

function App() {
  const [info, setInfo] = useState(null);
  const BACKEND_URL = "https://flask-render-iac-ronflex77.onrender.com/";

  useEffect(() => {
    fetch(`${BACKEND_URL}/info`)
      .then(res => res.json())
      .then(data => setInfo(data))
      .catch(err => console.error("Erreur backend:", err));
  }, []);

  return (
    <div style={{ textAlign: 'center', marginTop: '50px', fontFamily: 'sans-serif' }}>
      <h1>Atelier : React + Flask + PostgreSQL</h1>
      {info ? (
        <div style={{ border: '2px solid green', display: 'inline-block', padding: '20px' }}>
          <p>✅ Backend connecté !</p>
          <p><strong>Étudiant :</strong> {info.student}</p>
          <p><strong>Environnement :</strong> {info.env}</p>
        </div>
      ) : (
        <p>Connexion au backend en cours...</p>
      )}
    </div>
  );
}

export default App;
