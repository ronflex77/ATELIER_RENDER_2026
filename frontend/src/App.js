import React, { useEffect, useState } from 'react';

function App() {
  const [info, setInfo] = useState(null);
  // Remplace "ronflex77" par ton pseudo GitHub réel si besoin
  const BACKEND_URL = "https://flask-render-iac-ronflex77.onrender.com";

  useEffect(() => {
    fetch(`${BACKEND_URL}/info`)
      .then(res => res.json())
      .then(data => setInfo(data))
      .catch(err => console.error("Erreur backend:", err));
  }, []);

  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>Atelier : React + Flask + PostgreSQL</h1>
      {info ? (
        <div style={{ border: '2px solid green', padding: '20px', display: 'inline-block' }}>
          <p>✅ Backend connecté !</p>
          <p>Étudiant : {info.student}</p>
        </div>
      ) : (
        <p>Connexion au backend...</p>
      )}
    </div>
  );
}

export default App;
