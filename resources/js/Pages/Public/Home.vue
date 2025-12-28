<template>
    <div class="min-h-screen bg-gray-50">
        <!-- Header de navigation -->
        <header class="bg-white shadow sticky top-0 z-50">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <!-- Logo -->
                    <Link href="/" class="text-2xl font-bold text-blue-600">
                        🏠 ImmoGest
                    </Link>
                    
                    <!-- Menu Navigation -->
                    <div class="hidden md:flex space-x-8">
                        <Link href="/" class="text-gray-700 hover:text-blue-600">Accueil</Link>
                        <Link href="/biens" class="text-gray-700 hover:text-blue-600">Nos Biens</Link>
                        <Link href="/a-propos" class="text-gray-700 hover:text-blue-600">À propos</Link>
                        <Link href="/contact" class="text-gray-700 hover:text-blue-600">Contact</Link>
                    </div>
                    
                    <!-- Boutons Connexion -->
                    <div class="flex items-center space-x-4">
                        <Link href="/login" class="text-gray-700 hover:text-blue-600 font-medium">
                            Se connecter
                        </Link>
                        <Link href="/register" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                            S'inscrire
                        </Link>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Hero Section -->
        <section class="relative bg-gradient-to-r from-blue-600 to-blue-800 text-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
                <div class="text-center">
                    <h1 class="text-5xl font-bold mb-6">
                        Trouvez Votre Logement Idéal
                    </h1>
                    <p class="text-xl mb-8 text-blue-100">
                        Des milliers d'appartements, maisons et bureaux disponibles à la location
                    </p>
                    <Link 
                        href="/biens" 
                        class="inline-block bg-white text-blue-600 px-8 py-4 rounded-lg text-lg font-semibold hover:bg-gray-100 transition"
                    >
                        Découvrir nos biens
                    </Link>
                </div>
            </div>
        </section>

        <!-- Section Types de Biens -->
        <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
            <h2 class="text-3xl font-bold text-center mb-12">Que recherchez-vous ?</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                <div class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                    <div class="text-5xl mb-4">🏢</div>
                    <h3 class="text-xl font-semibold mb-2">Appartements</h3>
                    <p class="text-gray-600">Studios, T2, T3, T4...</p>
                </div>
                
                <div class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                    <div class="text-5xl mb-4">🏡</div>
                    <h3 class="text-xl font-semibold mb-2">Maisons</h3>
                    <p class="text-gray-600">Villas, duplex...</p>
                </div>
                
                <div class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                    <div class="text-5xl mb-4">🏢</div>
                    <h3 class="text-xl font-semibold mb-2">Bureaux</h3>
                    <p class="text-gray-600">Espaces professionnels</p>
                </div>
                
                <div class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                    <div class="text-5xl mb-4">🏪</div>
                    <h3 class="text-xl font-semibold mb-2">Commerces</h3>
                    <p class="text-gray-600">Boutiques, locaux...</p>
                </div>
            </div>
        </section>

        <!-- Section Statistiques -->
        <section class="bg-blue-600 text-white py-16">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                    <div>
                        <div class="text-5xl font-bold mb-2">500+</div>
                        <div class="text-blue-100">Biens disponibles</div>
                    </div>
                    <div>
                        <div class="text-5xl font-bold mb-2">1000+</div>
                        <div class="text-blue-100">Clients satisfaits</div>
                    </div>
                    <div>
                        <div class="text-5xl font-bold mb-2">15+</div>
                        <div class="text-blue-100">Années d'expérience</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gray-900 text-gray-400 py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <p>&copy; 2024 ImmoGest. Tous droits réservés.</p>
            </div>
        </footer>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
</script>