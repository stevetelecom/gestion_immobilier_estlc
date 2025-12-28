

<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// ========================================
// 🌐 PARTIE PUBLIQUE - ACCESSIBLE À TOUS
// ========================================

// Page d'accueil publique
Route::get('/', function () {
    return Inertia::render('Public/Home');
})->name('home');

// Catalogue des biens disponibles (tout le monde peut voir)
Route::get('/biens', function () {
    // Pour l'instant, données fictives
    $biens = [
        [
            'id' => 1,
            'titre' => 'Appartement moderne T3',
            'type' => 'Appartement',
            'ville' => 'Yaoundé',
            'quartier' => 'Bastos',
            'prix' => 150000,
            'surface' => 85,
            'chambres' => 2,
            'image' => 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        ],
        [
            'id' => 2,
            'titre' => 'Villa avec piscine',
            'type' => 'Maison',
            'ville' => 'Douala',
            'quartier' => 'Bonapriso',
            'prix' => 450000,
            'surface' => 250,
            'chambres' => 5,
            'image' => 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        ],
        [
            'id' => 3,
            'titre' => 'Studio étudiant meublé',
            'type' => 'Studio',
            'ville' => 'Yaoundé',
            'quartier' => 'Ngoa-Ekellé',
            'prix' => 65000,
            'surface' => 25,
            'chambres' => 1,
            'image' => 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
        ],
        [
            'id' => 4,
            'titre' => 'Bureau commercial',
            'type' => 'Bureau',
            'ville' => 'Yaoundé',
            'quartier' => 'Centre-ville',
            'prix' => 200000,
            'surface' => 120,
            'chambres' => 0,
            'image' => 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
        ],
    ];
    
    return Inertia::render('Public/Biens/Index', [
        'biens' => $biens
    ]);
})->name('biens.index');

// Détails d'un bien (tout le monde peut voir)
Route::get('/bien/{id}', function ($id) {
    // Pour l'instant, données fictives
    $bien = [
        'id' => $id,
        'titre' => 'Appartement moderne T3',
        'type' => 'Appartement',
        'description' => 'Magnifique appartement T3 situé dans un quartier calme et résidentiel. Proche de toutes commodités.',
        'ville' => 'Yaoundé',
        'quartier' => 'Bastos',
        'adresse' => '123 Rue de la Paix, Bastos',
        'prix' => 150000,
        'surface' => 85,
        'chambres' => 2,
        'salles_bain' => 1,
        'images' => [
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
            'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
        ],
        'equipements' => ['Climatisation', 'Cuisine équipée', 'Parking', 'Sécurité 24h/24'],
    ];
    
    return Inertia::render('Public/Biens/Show', [
        'bien' => $bien
    ]);
})->name('biens.show');

// À propos
Route::get('/a-propos', function () {
    return Inertia::render('Public/About');
})->name('about');

// Contact
Route::get('/contact', function () {
    return Inertia::render('Public/Contact');
})->name('contact');

// ========================================
// 🔒 PARTIE PRIVÉE - CONNEXION REQUISE
// ========================================

Route::middleware(['auth', 'verified'])->group(function () {
    
    // Dashboard (après connexion)
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
    
    // Gestion des biens (ajouter, modifier, supprimer)
    // Route::resource('properties', PropertyController::class);
    
    // Gestion des contrats
    // Route::resource('contracts', ContractController::class);
    
    // Gestion des paiements
    // Route::resource('payments', PaymentController::class);
    
    // Profile
    Route::get('/profile', function () {
        return Inertia::render('Profile/Edit');
    })->name('profile.edit');
});

// Routes d'authentification (login, register, etc.)
require __DIR__.'/auth.php';