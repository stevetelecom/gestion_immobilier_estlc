<template>
    <div class="min-h-screen bg-gray-50">
        <!-- Header -->
        <header class="bg-white shadow sticky top-0 z-50">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <Link href="/" class="text-2xl font-bold text-blue-600">🏠 ImmoGest</Link>
                    
                    <div class="hidden md:flex space-x-8">
                        <Link href="/" class="text-gray-700 hover:text-blue-600">Accueil</Link>
                        <Link href="/biens" class="text-gray-700 hover:text-blue-600">Nos Biens</Link>
                        <Link href="/a-propos" class="text-gray-700 hover:text-blue-600">À propos</Link>
                        <Link href="/contact" class="text-gray-700 hover:text-blue-600">Contact</Link>
                    </div>
                    
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

        <!-- Contenu -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <!-- Bouton retour -->
            <Link href="/biens" class="inline-flex items-center text-blue-600 hover:text-blue-800 mb-6">
                ← Retour à la liste
            </Link>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Galerie d'images -->
                <div class="lg:col-span-2">
                    <div class="bg-white rounded-lg shadow overflow-hidden">
                        <img 
                            :src="bien.images[0]" 
                            :alt="bien.titre"
                            class="w-full h-96 object-cover"
                        >
                        <div class="grid grid-cols-3 gap-2 p-4">
                            <img 
                                v-for="(image, index) in bien.images.slice(1)" 
                                :key="index"
                                :src="image" 
                                class="w-full h-24 object-cover rounded cursor-pointer hover:opacity-75"
                            >
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="bg-white rounded-lg shadow p-6 mt-6">
                        <h2 class="text-2xl font-bold mb-4">Description</h2>
                        <p class="text-gray-700 leading-relaxed">{{ bien.description }}</p>
                        
                        <h3 class="text-xl font-bold mt-6 mb-3">Équipements</h3>
                        <div class="flex flex-wrap gap-2">
                            <span 
                                v-for="equipement in bien.equipements" 
                                :key="equipement"
                                class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm"
                            >
                                ✓ {{ equipement }}
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Carte de contact -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow p-6 sticky top-24">
                        <div class="mb-4">
                            <span class="text-sm text-gray-600">{{ bien.type }}</span>
                            <h1 class="text-2xl font-bold mt-1">{{ bien.titre }}</h1>
                            <p class="text-gray-600 mt-2">📍 {{ bien.adresse }}</p>
                        </div>

                        <div class="border-t border-b py-4 my-4">
                            <div class="text-3xl font-bold text-blue-600 mb-4">
                                {{ bien.prix.toLocaleString() }} FCFA/mois
                            </div>
                            
                            <div class="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <div class="text-gray-600">Surface</div>
                                    <div class="font-semibold">{{ bien.surface }} m²</div>
                                </div>
                                <div>
                                    <div class="text-gray-600">Chambres</div>
                                    <div class="font-semibold">{{ bien.chambres }}</div>
                                </div>
                                <div>
                                    <div class="text-gray-600">Salles de bain</div>
                                    <div class="font-semibold">{{ bien.salles_bain }}</div>
                                </div>
                            </div>
                        </div>

                        <div class="space-y-3">
                            <button class="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700 font-semibold">
                                📞 Contacter
                            </button>
                            <button class="w-full border-2 border-blue-600 text-blue-600 py-3 rounded-lg hover:bg-blue-50 font-semibold">
                                📅 Demander une visite
                            </button>
                        </div>

                        <p class="text-xs text-gray-500 mt-4 text-center">
                            Connectez-vous pour accéder à plus de fonctionnalités
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-gray-900 text-gray-400 py-8 mt-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <p>&copy; 2024 ImmoGest. Tous droits réservés.</p>
            </div>
        </footer>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    bien: Object
});
</script>